import { PayloadAction, configureStore, Action, Dispatch } from "@reduxjs/toolkit"

interface IUser {
    id: number
    email: string
}

interface IAppState {
    logged_in: boolean
    user_data?: IUser
}

const initialState: IAppState = {
    logged_in: false
}

export enum EPayloadlessActions {
    LOG_USER_OUT = 'LOG_USER_OUT',
}

export enum EPayloadActions {
    LOG_USER_IN = 'LOG_USER_IN',
}

export type AppAction = PayloadAction<IUser, EPayloadActions> | Action<EPayloadlessActions>

const LoggedInUserReducer = (state = initialState, action: AppAction): IAppState => {
    switch (action.type) {
        case EPayloadActions.LOG_USER_IN:
            return {
                ...state,
                user_data: action.payload,
                logged_in: true
            }
        case EPayloadlessActions.LOG_USER_OUT:
            return {
                ...state,
                user_data: undefined,
                logged_in: false
            }
        default:
            return state
    }
}

export const store = configureStore({
    reducer: {
        user: LoggedInUserReducer
    }
  })

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = Dispatch<AppAction>
