class TipoController < ApplicationController
 before_action  :tipo_filtro
def index
    if  user_signed_in?
      @tipo= Tipo.all
    else 
      redirect_to registrar_path
    end  
  end 

 def edit
    if  user_signed_in?
       @tipo= Tipo.find(params[:id])
    else
      redirect_to registrar_path, alert: 'Primero debe estar registrado'
    end 
  end

   def update
    @tipo= Tipo.find(params[:id])
     if  user_signed_in?
      respond_to do |format|
        if @tipo.update(tipo_params)
          format.html { redirect_to tipo_path, notice: 'el tipo fue actualizado .' }
        end
      end
    else
      redirect_to registrar_path, alert: 'Primero debe estar registrado'
    end 
  end

  def show
    if  user_signed_in?
           redirect_to tipo_path
    else 
      redirect_to registrar_path
    end   
  end

  def new
    if  user_signed_in?
      @tipo = Tipo.new
    else
      redirect_to registrar_path
    end 
  end

  def create
    if  user_signed_in?
      @tipo = Tipo.new(tipo_params)
      respond_to do |format|
      if @tipo.save
        format.html { redirect_to tipo_path, notice: 'el tipo fue guardado correctamente' } 
      else
        format.html { render :new }
      end
    end
    else
      redirect_to registrar_path
    end 
  end

def destroy
    if  user_signed_in?
      @tipo=Tipo.find(params['id'])
      @user= User.where("tipo_id =?", @tipo)
      if @user.empty?
        respond_to do |format|
          @tipo.destroy
          format.html { redirect_to inicio_path, notice: 'el tipo fue eliminado' }
          #format.json { head :no_content }
        end
      else
        @user.each do |user|
          user.update(tipo_id: 1)
        end
          @tipo.destroy
          redirect_to inicio_path,  notice: 'el tipo fue eliminado'
      end
    else
      redirect_to registrar_path, alert: 'Primero debe estar registrado'
    end 
end

  private
   def tipo_filtro
      if  user_signed_in?
        if @current_user.tipo_id == 3
        else
          redirect_to inicio_path , alert: 'acceso denegado'
        end 
      else
         redirect_to registrar_path, alert: 'Primero debe estar registrado'
      end 
    end 
    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_params
      params.require(:tipo).permit(:descripcion)
    end
end
