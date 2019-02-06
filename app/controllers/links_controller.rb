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
        @link.body = doc.css("p").text
        @link.title = doc.css("h1").text
        @link.save
        redirect_to @link
    end

    private

    def links_params
        params.require(:link).permit(:link)
    end
end
