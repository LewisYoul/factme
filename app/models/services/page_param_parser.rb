module Services
  class PageParamParser
    DEFAULT_PAGE = 1

    def initialize(page_param:)
      @page_param = page_param
    end

    def parse
      if parsed_page_param > 0
        parsed_page_param
      else
        DEFAULT_PAGE
      end
    end

    private

    attr_reader :page_param

    def parsed_page_param
      @parsed_page_param ||= page_param.try(:to_i) || 0
    end
  end
end