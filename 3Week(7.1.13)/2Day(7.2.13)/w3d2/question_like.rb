require_relative 'question'
require_relative 'user'
require_relative 'questions_database'

class QuestionLike

  attr_reader :id, :user_id, :question_id

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT  *
      FROM    question_likes
      WHERE   id = ?
    SQL
    QuestionLike.new(QuestionsDatabase.execute(query, id).first)
  end

  def self.likers_for_question_id(question_id)
    query = <<-SQL
      SELECT  users.*
      FROM    users
      JOIN    question_likes
      ON      users.id = question_likes.user_id
      WHERE   question_likes.question_id = ?
    SQL
    QuestionsDatabase.execute(query, question_id).map {|attr| User.new(attr)}
  end

  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
      SELECT  COUNT(question_likes.user_id) AS num_likes
      FROM    question_likes
      WHERE   question_likes.question_id = ?
    SQL
    QuestionsDatabase.execute(query, question_id).first["num_likes"]
  end

  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT  questions.*
      FROM    questions
      JOIN    question_likes
      ON      questions.id = question_likes.question_id
      WHERE   question_likes.user_id = ?
    SQL
    QuestionsDatabase.execute(query, user_id).map {|attr| Question.new(attr)}
  end

  def self.most_liked_questions(n = 1)
    query = <<-SQL
      SELECT    questions.*
      FROM      questions
      JOIN      question_likes
      ON        questions.id = question_likes.question_id
      GROUP BY  question_likes.question_id
      ORDER BY  COUNT(question_likes.question_id) DESC
    SQL
    QuestionsDatabase.execute(query).map {|attr| Question.new(attr)}[0...n]
  end
end