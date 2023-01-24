export interface UserModel {
  id: number;
  username: string;
  created_at: Date;
}

export interface PostModel {
  id: number;
  title: string;
  content: string;
  user_id: number;
  creator: string;
  created_at: Date;
  upvotes: number;
}

export interface CommentModel {
  id: number;
  content: string;
  user_id: number;
  creator: string;
  post_id: number;
  created_at: Date;
  updated_at: Date;
}

export interface CategoryModel {
  id: number;
  name: string;
}