import { configureStore, Dispatch } from "@reduxjs/toolkit"
import { UserActions, LoggedInUserReducer } from "./UserStore"

export const store = configureStore({
    reducer: {
        user: LoggedInUserReducer
    }
  })

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = Dispatch<UserActions>
