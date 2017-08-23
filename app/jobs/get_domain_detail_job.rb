class GetDomainDetailJob < ApplicationJob
  queue_as :default

  def perform(number_id)

    analyzes = Number.find(number_id).analyzes

    analyzes.each do |analyze|

      url = analyze.domain
      unless analyze.domain.scan(/http:\/\//).present?
        unless analyze.domain.scan(/https:\/\//).present?
          url = "http://" + analyze.domain
        end
      end

      response = RestClient.get url
      doc = Nokogiri::HTML.parse(response.body)

      analyze.title = doc.css("title").to_s.gsub(/<\/?\w+>/, "")

        analyze.description = doc.search("meta[name='description'], meta[name='Description']").map{|n| n["content"]}.first
        analyze.keyword = doc.search("meta[name='keywords'], meta[name='Keywords']").map{|n| n["content"]}.first

      analyze.domain = url

      analyze.save

    end

  end
end
