import { PostModel, PostArrayModel } from "../models/redux-model";
import { createSlice, PayloadAction } from "@reduxjs/toolkit";

const initialPostState:PostArrayModel = {
  all_posts: [],
  particular_post: {
    "id": 0,
    "title": "",
    "content": "",
    "user_id": 0,
    "creator": "",
    "created_at": new Date("2023-01-25"),
    "upvotes": 0,
  }
}

const postSlice = createSlice({
  name: "posts",
  initialState: initialPostState,
  reducers: {
    setPosts(state, action: PayloadAction<PostModel[]>) {
      state.all_posts = action.payload;
    }, 
    setParticularPost(state, action: PayloadAction<PostModel>) {
      state.particular_post = action.payload;
    }
  }
});

export default postSlice;