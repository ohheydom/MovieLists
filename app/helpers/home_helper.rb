module HomeHelper

  def page_title(separator = " - ")
	  [content_for(:title), 'Movie Lists'].compact.join(separator)
  end

end
