# Requires: lessc (npm install -g less)
Jekyll::Hooks.register :site, :pre_render do |site|
  less_src = File.join(site.source, "assets/css/samettof.less")
  css_dest = File.join(site.source, "assets/dist/css/samettof.css")

  if !File.exist?(css_dest) || File.mtime(less_src) > File.mtime(css_dest)
    Jekyll.logger.info "LESS:", "Compiling #{less_src}"
    success = system("lessc #{less_src} #{css_dest}")
    Jekyll.logger.error "LESS:", "lessc failed — is it installed? (npm install -g less)" unless success
  end
end
