# Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>

c = {}

c.IDS =
  INITIATIVE : "2cd00bebec0c48ba9db761da48678134"
  EVENT      : "c2dc278a2d6a4b9b8a50cb606fc017ed"
  COMPANY    : "77b3c33a92554bcf8e8c2c86cedd6f6f"

c.MAIN_IDS = [c.IDS.INITIATIVE, c.IDS.EVENT, c.IDS.COMPANY]

c.CSS_CLASSES = {}
c.CSS_CLASSES[c.IDS.INITIATIVE] = "initiative"
c.CSS_CLASSES[c.IDS.EVENT]      = "event"
c.CSS_CLASSES[c.IDS.COMPANY]    = "company"

c.CSS_CLASS_SIZE = {}
c.CSS_CLASS_SIZE[c.IDS.INITIATIVE] = "pure-u-8-24"
c.CSS_CLASS_SIZE[c.IDS.EVENT]      = "pure-u-7-24"
c.CSS_CLASS_SIZE[c.IDS.COMPANY]    = "pure-u-9-24"
t = (x) -> x
c.NAMES = {}
c.NAMES[c.IDS.INITIATIVE]  = t "category.initiative"
c.NAMES[c.IDS.EVENT]       = t "category.event"
c.NAMES[c.IDS.COMPANY]     = t "category.company"

module.exports = c
