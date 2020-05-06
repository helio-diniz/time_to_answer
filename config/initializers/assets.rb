# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# pre-compilaação para app/assets
Rails.application.config.assets.precompile += %w( admins_backoffice.js admins_backoffice.css 
  admin_devise.js admin_devise.css user_devise.js user_devise.css 
  users_backoffice.js users_backoffice.css site.js site.css 
  img.jpg)

# pre-compilaação para lib/assets
Rails.application.config.assets.precompile += %w( sb-admin-2.min.js sb-admin-2.min.css, custom.min.js, custom.min.css, navbar-top-fixed.css )

# pre-compilaação para vendor/assets
Rails.application.config.assets.precompile += %w( jquery/dist/jquery.min jquery-2.2.3/dist/jquery.min.js bootstrap-4.3.1/bootstrap.bundle.js bootstrap-4.3.1/bootstrap.css )