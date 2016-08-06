# Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>

React          = require "react"
T              = React.PropTypes
udeep          = require "updeep"
validation     = require "../util/validation"
{ IDS        } = require "../constants/Categories"
{ reduxForm  } = require "redux-form"
{ CC_LICENSE } = require "../constants/URLs"
{ EDIT       } = require "../constants/Form"
Actions       = require "../Actions"

{
  div,
  h3,
  span,
  form,
  fieldset,
  legend,
  label,
  input,
  button,
  textarea,
  select,
  i,
  a,
  option
} = React.DOM

FIELD_PROPS =

  title       : { type: "text" }
  description : { type: "text" }
  homepage    : { type: "text" }
  telephone   : { type: "text" }
  street      : { type: "text" }
  city        : { type: "text" }
  zip         : { type: "text" }
  email       : { type: "email" }
  lat         : { type: "text", readOnly: yes }
  lng         : { type: "text", readOnly: yes }
  license     : { type: "checkbox"            }

Form = React.createClass

  displayName: "NewEntryForm"

  propTypes:
    fields        : T.object.isRequired
    handleSubmit  : T.func.isRequired
    isEdit        : T.bool

  render: ->
    t = (x) -> x
    { fields, handleSubmit, onCancel, isEdit } = @props
    { title, description, homepage, telephone, lat, lng, category,
      city, zip, street, email, license } = fields

    fieldProps = udeep FIELD_PROPS, fields

    classes =
      title       : className: "pure-input-1", placeholder: t "entryForm.title"
      description : className: "pure-input-1", placeholder: t "entryForm.description"
      homepage    : className: "pure-input-1", placeholder: t "entryForm.homepage"
      telephone   : className: "pure-input-1", placeholder: t "entryForm.phone"
      street      : className: "pure-input-1", placeholder: t "entryForm.street"
      city        : className: "pure-input-1", placeholder: t "entryForm.city"
      zip         : className: "pure-input-1", placeholder: t "entryForm.zip"
      email       : className: "pure-input-1", placeholder: t "entryForm.email"
      lat         : className: "pure-input-1"
      lng         : className: "pure-input-1"
      category    : className: "pure-input-1"

    for k,f of fieldProps when classes[k]? and f.error and f.touched
      classes[k].className += " err"

    fieldProps = udeep classes, fieldProps

    form {
      onSubmit: handleSubmit,
      className: "add-entry-form",
      action: 'javascript:void();'
      },
      h3 null, if isEdit then t "entryForm.edit" else t "entryForm.new"
      @props.error and div className: "err",
        "Der Eintrag konnte nicht gespeichert werden: #{@props.error.message}"
      (not @props.error) and @props.submitFailed and div className: "err",
        "Bitte überprüfen Sie ihre Eingaben!"
      license.error and license.touched and div className:"err",
        license.error
      div className: "pure-form",

        fieldset null,
          select fieldProps.category,
            option value: -1, t "entryForm.choseCategory"
            option value: IDS.INITIATIVE, t "category.initiative"
            option value: IDS.EVENT,      t "category.event"
            option value: IDS.COMPANY,    t "category.company"
          category.error and category.touched and div className: "err",
            category.error

          input fieldProps.title
          title.error and title.touched and div className: "err",
            title.error

          textarea fieldProps.description
          description.error and description.touched and div className:"err",
            description.error

        fieldset null,
          legend null,
            span className:"text",t "entryForm.location"
            span className:"desc",t "entryForm.clickMap"

          div className: "pure-g",
            label className: "pure-u-2-24",
              i className: "fa fa-map-marker"
            div className: "pure-u-22-24 pure-g",
              div className: "pure-u-11-24",
                input fieldProps.lat
                lat.error and lat.touched and div className: "err", lat.error
              div className: "pure-u-2-24"
              div className: "pure-u-11-24",
                input fieldProps.lng
                lng.error and lng.touched and div className: "err", lng.error
        fieldset null,
          input fieldProps.street
          street.error and street.touched and div className:"err",
            street.error
          div className: "pure-g",
            div className: "pure-u-6-24",
              input fieldProps.zip
              zip.error and zip.touched and div className:"err",
                zip.error
            div className: "pure-u-18-24",
              input fieldProps.city
              city.error and city.touched and div className:"err",
                city.error

        fieldset null,
          legend null, t "entryForm.contact"
          div className: "pure-g",
            label className: "pure-u-2-24",
              i className: "fa fa-globe"
            div className: "pure-u-22-24",
              input fieldProps.homepage
              homepage.error and homepage.touched and div className:"err",
                homepage.error

          div className: "pure-g",
            label className: "pure-u-2-24",
              i className: "fa fa-envelope"
            div className: "pure-u-22-24",
              input fieldProps.email

          div className: "pure-g",
            label className: "pure-u-2-24",
              i className: "fa fa-phone"
            div className: "pure-u-22-24",
              input fieldProps.telephone

        fieldset null,
          legend null,
            span className:"text",t "entryForm.license"
            span className:"desc","(CC-0)"
          div className: "pure-g license",
            label className: "pure-u-2-24",
              i className: "fa fa-creative-commons"
            div className: "pure-u-2-24 pure-controls",
              input fieldProps.license
            div className: "pure-u-20-24",
              license.error and license.touched and div className:"err",
                license.error
              t "entryForm.iHaveRead"
              a href: CC_LICENSE.link,
                t "entryForm.creativeCommonsAccepted"

module.exports = reduxForm(
  form            : EDIT.id
  fields          : EDIT.fields
  validate        : validation.entryForm
  asyncBlurFields : ['street', 'zip', 'city']
  asyncValidate   : (values, dispatch) ->
    dispatch Actions.geocodeAndSetMarker (
      (if values.street then values.street + ' ' else '').concat(
        (if values.zip then values.zip + ' ' else '').concat(
          (if values.city then values.city else '')
        )
      )
    )
    new Promise (resolve, reject) -> resolve()
)(Form)
