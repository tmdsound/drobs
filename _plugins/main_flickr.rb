require 'open-uri'
require 'nokogiri'

module Jekyll
  class MainPhotoTag < Liquid::Tag

      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
        @ft   = @markup.split(' ')[0]
        @lb   = @markup.split(' ')[1]
        
        end

        # подключаем Nokogiri
        def render(context)
          @api_key = context.registers[:site].config["flickr"]["api_key"]
          
          page = Nokogiri::HTML(open("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=#{@api_key}&photo_id=#{@ft}"))
            if @lb
              @label = @lb
            else
              @label = 'Medium'
            end
            
            page.css("size[label='#{@label}']").each do |el|
         
              @foto = {
                :width => el['width'],
                :height => el['height'],
                :source => el['source'],
              }
            
          end
          doc = Nokogiri::HTML(open("https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=#{@api_key}&photo_id=#{@ft}"))
          doc.css("photo").each do |link|
            @f_info = {
              :title => doc.css('title').inner_text,
              :description => doc.css('description').inner_text
            }

          end
          puts '#{@lb}'
          puts '#{@ft}'
          "<img src=\"#{@foto[:source]}\" width=\"#{@foto[:width]}\" height=\"#{@foto[:height]}\" alt=\"#{@f_info[:title]}\" title=\"#{@f_info[:description]}\" >"
      
        end

  end
end

Liquid::Template.register_tag('main_photo', Jekyll::MainPhotoTag)