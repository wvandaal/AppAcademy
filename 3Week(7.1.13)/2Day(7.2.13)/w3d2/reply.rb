require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class Reply

  attr_reader :id, :author_id, :question_id, :parent_id, :body

  def initialize(options = {})
    @id = options["id"]
    @author_id = options["author_id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @body = options["body"]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT  *
      FROM    replies
      WHERE   id = ?
    SQL
    Reply.new(QuestionsDatabase.execute(query, id).first)
  end

  def self.find_by_question_id(question_id)
    query = <<-SQL
      SELECT  *
      FROM    replies
      WHERE   question_id = ?
    SQL
    QuestionsDatabase.execute(query, question_id).map {|attr| Reply.new(attr)}
  end

  def self.find_by_user_id(user_id)
    query = <<-SQL
      SELECT  *
      FROM    replies
      WHERE   author_id = ?
    SQL
    QuestionsDatabase.execute(query, user_id).map {|attr| Reply.new(attr)}
  end

  def author
    User::find_by_id(@author_id)
  end

  def question
    Question::find_by_id(@question_id)
  end

  def parent_reply
    Reply::find_by_id(@parent_id)
  end

  def child_replies
    query = <<-SQL
      SELECT  *
      FROM    replies
      WHERE   parent_id = ?
    SQL
    QuestionsDatabase.execute(query, @id).map {|attr| Reply.new(attr)}
  end

end