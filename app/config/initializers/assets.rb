# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( admins.js )
Rails.application.config.assets.precompile += %w( blogs.js )
Rails.application.config.assets.precompile += %w( proposals.js )
Rails.application.config.assets.precompile += %w( proposal_comments.js )
Rails.application.config.assets.precompile += %w( landingpages.js )
Rails.application.config.assets.precompile += %w( ideas.js )
Rails.application.config.assets.precompile += %w( pages.js )
Rails.application.config.assets.precompile += %w( ideas.js )
Rails.application.config.assets.precompile += %w( votes.js )
Rails.application.config.assets.precompile += %w( categories.js )
Rails.application.config.assets.precompile += %w( instafeed.min.js )
