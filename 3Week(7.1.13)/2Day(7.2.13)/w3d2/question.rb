require_relative 'user'
require_relative 'questions_database'
require_relative 'question_follower'

class Question

  attr_reader :id, :author_id, :title, :body

  def initialize(options = {})
    @id = options["id"]
    @author_id = options["author_id"]
    @title = options["title"]
    @body = options["body"]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT  *
      FROM    questions
      WHERE   id = ?
    SQL
    Question.new(QuestionsDatabase.execute(query, id).first)
  end

  def self.find_by_author_id(author_id)
    query = <<-SQL
      SELECT  *
      FROM    questions
      WHERE   author_id =?
    SQL
    QuestionsDatabase.execute(query, author_id).map {|attr| Question.new(attr)}
  end

  def self.most_liked(n = 1)
    QuestionLike::most_liked_questions(n)
  end

  def self.most_followed
    QuestionFollower::most_followed_questions
  end

  def author
    User::find_by_id(@author_id)
  end

  def replies
    Reply::find_by_question_id(@id)
  end

  def followers
    QuestionFollower::followers_for_question_id(@id)
  end

  def likers
    QuestionLike::likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike::num_likes_for_question_id(@id)
  end

end