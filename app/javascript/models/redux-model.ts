export interface UserModel {
  "id": number,
  "username": string,
  "password": string,
  "created_at": Date,
}

export interface PostModel {
  "id": number,
  "title": string,
  "content": string,
  "user_id": number,
  "creator": string,
  "created_at": Date,
  "upvotes": number,
}

export interface PostArrayModel {
  all_posts: PostModel[],
  particular_post: PostModel,
}

export interface CommentModel {
  "id": number,
  "content": string,
  "user_id": number,
  "creator": string,
  "post_id": number,
  "created_at": Date,
  "updated_at": Date,
}

export interface CategoryModel {
  "id": number,
  "name": string,
}

export interface CategoryArrayModel {
  "all_categories": CategoryModel[],
  "selected_categories": CategoryModel[],
}