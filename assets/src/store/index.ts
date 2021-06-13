import { configureStore, Dispatch } from "@reduxjs/toolkit"
import { UserActions, LoggedInUserReducer } from "./UserStore"

// TODO: Introduce a store for storing configuration values for things like max amount of points to be given

export const store = configureStore({
    reducer: {
      user: LoggedInUserReducer
    }
  })

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = Dispatch<UserActions>
