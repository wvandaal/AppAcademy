require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follower'


class User

  attr_reader :id, :fname, :lname

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT  *
      FROM    users
      WHERE   id = ?
    SQL
    QuestionsDatabase.execute(query, id).map {|attr| User.new(attr)}.first
  end

  def self.find_by_name(fname, lname)
    query = <<-SQL
      SELECT  *
      FROM    users
      WHERE   fname = ? AND lname = ?
    SQL
    QuestionsDatabase.execute(query, fname, lname).map {|attr| User.new(attr)}
  end

  def authored_questions
    Question::find_by_author_id(@id)
  end

  def authored_replies
    Reply::find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower::followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike::liked_questions_for_user_id(@id)
  end

  def average_karma
    query = <<-SQL
      SELECT  COUNT(question_likes.question_id)/COUNT(questions.author_id)
      FROM    questions
      JOIN    question_likes
      ON      questions.id = question_likes.question_id
      WHERE   questions.author_id = ?
      AND     question_likes.question_id IN
     (SELECT  id
     FROM     questions
     WHERE    questions.author_id = ?
     )
    SQL
    QuestionsDatabase.execute(query, @id, @id)
  end
end