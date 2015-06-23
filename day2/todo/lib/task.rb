class Task
  attr_reader :content
  def initialize(id, content)
    @id = id
    @content = content
  end
end