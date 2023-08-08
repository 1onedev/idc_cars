class PagesController < BaseController
  def contacts
    set_seo(load_page_contact_seo)
  end

  def faq
    @answers = Answer.order(position: :asc)

    set_seo(load_page_faq_seo)
  end

  private
  def load_page_contact_seo
    OpenStruct.new(seo_title: 'Контакти', seo_description: 'IDC | Пошук та доставка авто з Кореї! Великий вибір послуг та найкращі ціни! Послуга «Під ключ», Оптимальні варіанти, СТО, Ексклюзивність!', image: '/favicon/ou.jpg')
  end

  def load_page_faq_seo
    OpenStruct.new(seo_title: "Faq's", seo_description: 'IDC | Пошук та доставка авто з Кореї! Великий вибір послуг та найкращі ціни! Послуга «Під ключ», Оптимальні варіанти, СТО, Ексклюзивність!', image: '/favicon/ou.jpg')
  end
end
