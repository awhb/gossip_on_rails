import postSlice from "./postSlice";
import { AnyAction } from "@reduxjs/toolkit";
import { ThunkAction } from "@reduxjs/toolkit";
import { RootState } from "./index";
import { PostModel } from "../models/redux-model";
import postService from "../services/postService";

export const postActions = postSlice.actions;

export const fetchPosts = (): ThunkAction<void, RootState, unknown, AnyAction> => {
  return async (dispatch,getState) => {
    const response:PostModel[] = await postService.getAllPosts();
    dispatch(postActions.setPosts(response));
  };
}

export const fetchParticularPost = (post_id:number): ThunkAction<void, RootState, unknown, AnyAction> => { 
  return async (dispatch,getState) => {
    const response:PostModel = await postService.getParticularPost(post_id);
    dispatch(postActions.setParticularPost(response));
  };
}
