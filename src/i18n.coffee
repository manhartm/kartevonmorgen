i18n = require('i18next')
i18n.init(
  ns: 
    defaultNs: 'transaltion'
    namespaces: ['translation']
  lngWhiteList: ['de', 'en']
  fallbackLng: 'de'
  resGetPath: '/locales/%{ns}-%{lng}.json'
  interpolationPrefix: '%{'
  interpolationSuffix: '}'
  keyseparator: '.'
  nsseparator: '>'
)
i18next.changeLanguage('de')
module.exports = i18n