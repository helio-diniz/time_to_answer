class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :get_subjects, only: [:new, :edit]
  
  def index
    @questions = Question.includes(:subject)
      .order(:description).page(params[:page])
  end

  def edit 
  end

  def update 
    if @question.update(question_params) 
      redirect_to admins_backoffice_questions_path, notice: "Pergunta atualizada com sucesso!"
    else
      render :edit
    end    
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Pergunta cadstrada com sucesso!"
    else
      render :new
    end    
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Pergunta excluída com sucesso!"
    else
      render :index
    end    
  end

  private 

  def get_subjects
    @subjects = Subject.all.order(:description)
  end  

  def question_params 
    params.require(:question).permit(:description, :subject_id,
      answers_attributes: [:id, :description, :correct, :_destroy])
  end

  def set_question
    @question = Question.find(params[:id])
  end

end
