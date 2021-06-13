import { Action, PayloadAction } from '@reduxjs/toolkit'
import { IUser } from '../../types/user'

interface IAppState {
    logged_in: boolean
    user_data?: IUser
}

const initialState: IAppState = {
    logged_in: false
}

export enum EUserPayloadlessActions {
    LOG_USER_OUT = 'LOG_USER_OUT',
}

export enum EUserPayloadActions {
    LOG_USER_IN = 'LOG_USER_IN',
}

export type UserActions = PayloadAction<IUser, EUserPayloadActions> | Action<EUserPayloadlessActions>

export const LoggedInUserReducer = (state = initialState, action: UserActions): IAppState => {
    switch (action.type) {
    case EUserPayloadActions.LOG_USER_IN:
        return {
            ...state,
            user_data: action.payload,
            logged_in: true
        }
    case EUserPayloadlessActions.LOG_USER_OUT:
        return {
            ...state,
            user_data: undefined,
            logged_in: false
        }
    default:
        return state
    }
}