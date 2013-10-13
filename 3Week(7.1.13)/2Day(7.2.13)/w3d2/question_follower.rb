require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class QuestionFollower

  attr_reader :id, :user_id, :question_id

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT  *
      FROM    questions_followers
      WHERE   id = ?
    SQL
    QuestionFollower.new(QuestionsDatabase.execute(query, id).first)
  end

  def self.followers_for_question_id(question_id)
    query = <<-SQL
      SELECT  users.*
      FROM    users
      JOIN    questions_followers
      ON      users.id = questions_followers.user_id
      WHERE   questions_followers.question_id = ?
    SQL
    QuestionsDatabase.execute(query, question_id).map {|attr| User.new(attr)}
  end

  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT  questions.*
      FROM    questions
      JOIN    questions_followers
      ON      questions.id = questions_followers.question_id
      WHERE   questions_followers.user_id = ?
    SQL
    QuestionsDatabase.execute(query, user_id).map {|attr| User.new(attr)}
  end

  def self.most_followed_questions(n = 1)
    query = <<-SQL
      SELECT    questions.*
      FROM      questions
      JOIN      questions_followers
      ON        questions.id = questions_followers.question_id
      GROUP BY  questions_followers.question_id
      ORDER BY  COUNT(questions_followers.question_id) DESC
    SQL
    QuestionsDatabase.execute(query).map {|attr| Question.new(attr)}[0...n]
  end

end