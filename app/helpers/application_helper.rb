module ApplicationHelper
    require "redcarpet"
    require "coderay"

    class HTMLwithCoderay < Redcarpet::Render::HTML
        def block_code(code,language)
            language = language.split(':')[0] if language.present?
            
            case language.to_s
            when 'rb'
                lang = :ruby
            when 'yml'
                lang = :yaml
            when 'css'
                lang = :yaml
            when 'html'
                lang = :html
            when ''
                lang = :md
            else
                lang = language    
            end

            CodeRay.scan(code,lang).div
        end
    end

    def markdown(text) 
       html_reader = HTMLwithCoderay.new(
           filter_html: true,
           hard_wrap: true,
           link_attributes: { rel: 'nofllow',target: "_blank"}
       ) 
        options = {
            autolink: true,
            space_after_headers: true,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            tables: true,
            hard_wrap: true,
            lax_html_blocks: true,
            strikethrough: true
        }
        markdown = Redcarpet::Markdown.new(html_reader,options)
        markdown.render(text)
    end
end
