import { Action, PayloadAction } from '@reduxjs/toolkit'
import { IPrivateUser } from '../../types/user'

interface IOtherUsersState {
  users: IPrivateUser[]
}

const initialState: IOtherUsersState = {
  users: [],
}

export enum EOtherUsersPayloadActions {
  POPULATE = 'POPULATE',
}

export enum EOtherUsersPayloadlessActions {
  RESET = 'RESET',
}

export type OtherUsersActions =
  | PayloadAction<IPrivateUser[], EOtherUsersPayloadActions.POPULATE>
  | Action<EOtherUsersPayloadlessActions.RESET>

export const OtherUsersStoreReducer = (state = initialState, action: OtherUsersActions): IOtherUsersState => {
  switch (action.type) {
    case EOtherUsersPayloadActions.POPULATE:
      return {
        ...state,
        users: [...action.payload],
      }
    case EOtherUsersPayloadlessActions.RESET:
      return {
        ...state,
        users: [],
      }
    default:
      return state
  }
}
