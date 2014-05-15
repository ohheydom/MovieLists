module NullObjects
  class NoPosterPath
    def poster_path
    end
  end

  class NoReleaseDate
    def release_date
      '1900-01-01'
    end
  end

  class NotSignedIn
    FormData = Struct.new(:method, :submit, :trclass, :path)

    def form_data
      FormData.new('', '', 'noclass', '')
    end
  end
end
