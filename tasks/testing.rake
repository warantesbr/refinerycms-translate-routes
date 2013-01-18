namespace :refinery do
  namespace :testing do
    # Put any code in here that you want run when you test this extension against a dummy app.
    # For example, the call to require your gem and start your generator.
    task :setup_extension do
      require 'fileutils'
      FileUtils.cp "../fixtures/routes.yml", "config/locales/routes.yml"
      FileUtils.mkdir "app/views/refinery" unless File.exists? "app/views/refinery"
      FileUtils.mkdir "app/views/refinery/pages" unless File.exists? "app/views/refinery/pages"
      FileUtils.cp "../fixtures/page_show.html.erb", "app/views/refinery/pages/show.html.erb"
    end
  end
end
