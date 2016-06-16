class Idea < ActiveRecord::Base
	attr_accessible  :titulo ,:contenido,:visita,:estado_id, :user_id
	belongs_to :user# modelo a que pertenece
	belongs_to :estado
	has_many :mensaje
	has_many :denuncia #tiene muchos 
	has_many :aquirido
end
 