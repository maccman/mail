# encoding: utf-8
module Mail
  class ContentTypeElement
    
    include Mail::Utilities
    
    def initialize( string )
      parser = Mail::ContentTypeParser.new
      if tree = parser.parse(cleaned(string))
        @type = tree.type.text_value
        @sub_type = tree.sub_type.text_value
        @parameters = tree.parameters
      else
        raise Mail::Field::ParseError, "ContentTypeElement can not parse |#{string}|\nReason was: #{parser.failure_reason}\n"
      end
    end
    
    def type
      @type
    end
    
    def sub_type
      @sub_type
    end
    
    def parameters
      @parameters
    end
    
    def to_s(*args)
      "#{@info}; #{@date_time.to_s(*args)}"
    end
    
    def cleaned(string)
      string =~ /(.+);\s*$/ ? $1 : string
    end
    
  end
end
