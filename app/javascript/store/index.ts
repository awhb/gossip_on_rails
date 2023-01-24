// store.ts
import { configureStore } from "@reduxjs/toolkit";
import authReducer from './authSlice';
import postSlice from './postSlice';


const store = configureStore({
  reducer: {
    posts: postSlice.reducer,
    auth: authReducer,
  }
});


export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
export default store;