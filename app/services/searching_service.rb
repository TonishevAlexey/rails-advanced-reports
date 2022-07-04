class SearchingService
  attr_reader :result

  def initialize(search_params)
    @q = search_params[:q]
    @type = search_params[:type]
  end

  def call
    if @type.present?
      @result = @type.singularize.constantize.search ThinkingSphinx::Query.escape(@q)
    else
      @result = ThinkingSphinx.search ThinkingSphinx::Query.escape(@q)
    end
  end
end
