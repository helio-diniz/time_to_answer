namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')
  
  desc "Configuração do ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
        # usa-se chaves para quando apenas é commando de uma linha no bloco DO .. END
        show_spinner("Apagando BD ...") { %x(rails db:drop:_unsafe) }
        show_spinner("Criando BD ...") { %x(rails db:create) }
        show_spinner("Migrando BD ...") { %x(rails db:migrate) }
        show_spinner("Cadastrando o administrador padrão ...") { %x(rails dev:add_default_admin) }
        show_spinner("Cadastrando administradores extras ...") { %x(rails dev:add_extra_admins) }
        show_spinner("Cadastrando o usuário padrão ...") { %x(rails dev:add_default_user) }
        show_spinner("Cadastrando os assuntos padrões ...") { %x(rails dev:add_subjects) }
        show_spinner("Cadastrando os perguntas e respostas ...") { %x(rails dev:add_answers_and_questions) }
    else
        puts "Você não está em ambiente de desenvolvimento!"
    end    
  end
    
  desc "Adicionando o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com', 
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD)
  end

  desc "Adicionando administrador extra"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email, 
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD)
    end  
  end

  desc "Adicionando o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com', 
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD)
  end

  desc "Adicionando assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end  
  end

  desc "Adicionando perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_question_param(subject)
        answers_array = params[:question][:answers_attributes]
        add_answers(answers_array)
        elect_correct_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  desc "Re-inicializa o contador de assuntos"
  task reset_subject_counter: :environment do
    show_spinner("Re-inicializando o contador dos assuntos ...") do
      Subject.find_each do |subject|
          Subject.reset_counters(subject.id, :questions)
      end
    end  
  end

  private
  def create_question_param(subject = Subject.all.sample)
    { question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject,
          answers_attributes:[]
      }
    }
  end

  def create_answer_params(correct = false)
    {description: Faker::Lorem.sentence, correct: correct}
  end

  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(create_answer_params)
    end
  end  

  def elect_correct_answer(answers_array = [])
    index = rand(answers_array.size)
    answers_array[index] =  create_answer_params(true)
  end

  def show_spinner(start_msg, end_msg = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{start_msg}")
    spinner.auto_spin # Automatic animation with default interval        
    yield # executa o bloco de código dentro do DO .. END
    spinner.success("(#{end_msg})")
  end 
end
