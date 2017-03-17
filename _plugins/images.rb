require 'byebug'

module Jekyll
  module ImgixFilter

    def imgix(raw, opts={})
      @opts = opts
      base_url + raw + "?" + url_opts
    end

    def base_url
      @context.registers[:site].config.fetch("image_source", nil)
    end

    def url_opts
      @formatted_opts = {}
      @opts.keys.each do |k|
        new_key = k.gsub('_','-')
        @formatted_opts[new_key] = @opts[k]
      end
      URI.encode_www_form @formatted_opts
    end
  end
end

Liquid::Template.register_filter(Jekyll::ImgixFilter)
