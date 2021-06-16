import { Action, PayloadAction } from '@reduxjs/toolkit'
import { IUser } from '../../types/user'

interface IUserStoreState {
  logged_in: boolean
  user_data?: IUser
}

const initialState: IUserStoreState = {
  logged_in: false,
}

export enum EUserPayloadlessActions {
  LOG_USER_OUT = 'LOG_USER_OUT',
}

export enum EUserPayloadActions {
  LOG_USER_IN = 'LOG_USER_IN',
  UPDATE_POINTS = 'UPDATE_POINTS',
}

export type UserActions = PayloadAction<IUser, EUserPayloadActions> | Action<EUserPayloadlessActions>

export const LoggedInUserReducer = (state = initialState, action: UserActions): IUserStoreState => {
  switch (action.type) {
    case EUserPayloadActions.LOG_USER_IN:
      return {
        ...state,
        user_data: action.payload,
        logged_in: true,
      }
    case EUserPayloadlessActions.LOG_USER_OUT:
      return {
        ...state,
        user_data: undefined,
        logged_in: false,
      }
    case EUserPayloadActions.UPDATE_POINTS:
      return {
        ...state,
        user_data: {
          ...state.user_data,
          pool: {
            ...state.user_data.pool,
            points: action.payload.pool.points,
          },
        },
      }
    default:
      return state
  }
}
