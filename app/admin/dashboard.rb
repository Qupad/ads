ActiveAdmin.register_page "Dashboard" do
  menu priority: 1

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recently published advertise" do
          table_for Article.where(life_cycle: 'published').order("id desc").limit(10) do |article|
            column("Title") { |article| article.title }
            column("Text") { |article| article.text }
            column("Images") do |article| 
              ul do
                article.images.each do |i|
                  li do
                    image_tag(i, style: 'width:100%') 
                  end
                end
              end
            end
            column :user
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
