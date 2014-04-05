class List
  def initialize(id)
    @list ||= Tmdb::TheMovieDb.get_list_by_id(id)
  end

  def name
    @list['name']
  end

  def status_code
    @list['status_code']
  end

  def list
    @list['items']
  end

  def count
    list.count
  end

  def paginated_list(args = {})
    Kaminari.paginate_array(list).page(args[:page]).per(args[:per])
  end
end
