locals {
  # Build a final app map
  #   app_map = flatten([for key, app in var.apps :
  #     { for region in var.regions :
  #       "${key}-${region}" => {
  #         container_url          = app.container_url
  #         tag                    = app.tag
  #         url_map                = lookup(app, "url_map", false)
  #         needs_firestore_access = lookup(app, "needs_firestore_access", false)
  #         region                 = region
  #       }
  #     }
  #   ])
  # app_map = flatten([ for key, app in var.apps :
  #     [ for region in var.regions :
  #         "${key}-${region}" = {
  #             container_url = app.container_url
  #             tag = app.tag
  #             url_map = app.url_map ? app.url_map : false
  #             needs_firestore_access = app.needs_firestore_access ? false
  #             region = region
  #         }
  #     ]
  # ])
}
