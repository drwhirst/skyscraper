class LinksController < ApplicationController
    def index
        @link = Link.new
    end

    def show
        @link = Link.find(params[:id])
    end
    
    def create
        @link = Link.new(links_params)
        require 'open-uri'
        doc = Nokogiri::HTML(open(@link.link))

        doc.css("blockquote").each do |node|
            node.remove
        end

        the_css = doc.css('p')

        ub = Sanitize.fragment(the_css, :elements => ['p']).split(' ')
        title = doc.css("h1").text

        ub.each do |f|
            f.gsub!(".", ". ")
            f.gsub!("Advertisement", "")
            f.gsub!("Supported", "")
            f.gsub!("byBy", " By ")
            f.gsub!(". )", '.) ')
            f.gsub!(". ]", '.] ')
            f.gsub!('. "[', '" [')
            f.gsub!('by', '')
        end
        
        @link.body = ub.join(" ")
        @link.title = title
        @link.save
        redirect_to @link
    end

    private

    def links_params
        params.require(:link).permit(:link)
    end
end
