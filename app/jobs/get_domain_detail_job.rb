class GetDomainDetailJob < ApplicationJob
  queue_as :default

  def perform(number_id)

    analyzes = Number.find(number_id).analyzes

    analyzes.each do |analyze|

      response = RestClient.get analyze.domain
      doc = Nokogiri::HTML.parse(response.body)

      analyze.title = doc.css("title").to_s.gsub(/<\/?\w+>/, "")

        analyze.description = doc.search("meta[name='description'], meta[name='Description']").map{|n| n["content"]}.first
        analyze.keyword = doc.search("meta[name='keywords'], meta[name='Keywords']").map{|n| n["content"]}.first

      analyze.save

    end

  end
end
