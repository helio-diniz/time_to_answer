class AdminMailer < ApplicationMailer
  def update_email(current_admin, admin)
    # current_admin é o administrador que fez a alteração
    @current_admin = current_admin
    # admin é o administrador que foi alterado
    @admin = admin
    mail(to: @admin.email, subject: "Seus dados foram alterados!" )
  end
end
