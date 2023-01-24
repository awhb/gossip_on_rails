import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

export const login = createAsyncThunk("auth/login", async (payload) => {
    const {username, password} = payload;
    try {
        const response = await axios.post("/login", { username, password });
        localStorage.setItem("token", response.data.token);
        return response.data;
    } catch (error) {
        throw error.response.data.error;
    }
});

const authSlice = createSlice({
    name: "auth",
    initialState: {
        token: "",
        user: {},
        isAuthenticated: false,
        isLoading: false,
        error: null
    },
    reducers: {
        loginRequest: (state) => {
            state.isLoading = true;
        },
        loginSuccess: (state, { payload }) => {
            state.token = payload.token;
            state.user = payload.user;
            state.isAuthenticated = true;
            state.isLoading = false;
        },
        loginFailure: (state, { payload }) => {
            state.error = payload;
            state.isLoading = false;
        }
    },
    extraReducers: (builder) => {
        builder
            .addCase(login.pending, (state) => {
                state.isLoading = true;
            })
            .addCase(login.fulfilled, (state, action) => {
                state.token = action.payload.token;
                state.user = action.payload.user;
                state.isAuthenticated = true;
                state.isLoading = false;
            })
            .addCase(login.rejected, (state, action) => {
                state.error = action.payload as string;
                state.isLoading = false;
            });
    }
});

export const selectAuth = (state) => state.auth;

export default authSlice.reducer;
