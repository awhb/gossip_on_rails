import { PostModel } from "../models/redux-model";
import axios from "axios";

export default {
  async getAllPosts() {
    var response = await axios.get("/posts");
    return response.data;
  },
  async getParticularPost(post_id:number) {
    var response = await axios.get(`/posts/${post_id}`);
    return response.data;
  }
}