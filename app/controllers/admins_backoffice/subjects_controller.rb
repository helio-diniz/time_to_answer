class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_aubject, only: [:edit, :update, :destroy]
  
  def index
    @subjects = Subject.all.order(:description).page(params[:page])
  end

  def edit 
  end

  def update 
    if @subject.update(subject_params) 
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área atualizado com sucesso!"
    else
      render :edit
    end    
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área cadstrado com sucesso!"
    else
      render :new
    end    
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área excluído com sucesso!"
    else
      render :index
    end    
  end

  private 

  def subject_params 
    params.require(:subject).permit(:description)
  end

  def set_aubject
    @subject = Subject.find(params[:id])
  end

end

