require "http"
require "kilt"

module Kemalyst
  class Controller < HTTP::Handler

    def self.instance
      @@instance ||= new
    end

    def call(context)
      call_next context
    end

    macro render(filename, layout)
      content = Kilt.render("app/views/{{filename.id}}")
      layout = Kilt.render("app/views/layouts/{{layout.id}}")
      context.response.print(layout.to_s)
    end

    macro render(filename, *args)
      content = Kilt.render("app/views/{{filename.id}}", {{*args}})
      context.response.print(content.to_s)
    end

    macro redirect(url, status_code = 302)
      context.response.headers.add("Location", {{url}})
      context.response.status_code = {{status_code}}
    end

    macro status(body, status_code = 200)
      context.response.status_code = {{status_code}}
      context.response.print({{body}})
    end
   
  end
end

