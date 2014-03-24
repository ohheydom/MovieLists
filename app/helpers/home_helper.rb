module HomeHelper

  def page_title(separator = " - ")
	  [content_for(:title), 'My Movie Tracker'].compact.join(separator)
  end

end
