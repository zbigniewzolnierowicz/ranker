import { configureStore, Dispatch } from '@reduxjs/toolkit'
import { OtherUsersActions, OtherUsersStoreReducer } from './OtherUsersStore'
import { RewardStoreActions, RewardStoreReducer } from './RewardStore'
import { UserActions, LoggedInUserReducer } from './UserStore'

// TODO: Introduce a store for storing configuration values for things like max amount of points to be given

export const store = configureStore({
  reducer: {
    user: LoggedInUserReducer,
    store: RewardStoreReducer,
    otherUsers: OtherUsersStoreReducer,
  },
})

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = Dispatch<UserActions | RewardStoreActions | OtherUsersActions>
