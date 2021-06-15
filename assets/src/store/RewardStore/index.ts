import { Action, PayloadAction } from '@reduxjs/toolkit'
import type { IReward } from '../../types/reward'

export interface IRewardStoreState {
  rewards?: IReward[]
  loading: boolean
}

const initialState: IRewardStoreState = {
  rewards: undefined,
  loading: true,
}

export enum ERewardStorePayloadlessActions {
  RESET_STORE = 'RESET_STORE',
  START_LOADING = 'START_LOADING',
  STOP_LOADING = 'STOP_LOADING',
}

export enum ERewardStorePayloadActions {
  POPULATE_STORE = 'POPULATE_STORE',
}

export type RewardStoreActions =
  | PayloadAction<IReward[], ERewardStorePayloadActions.POPULATE_STORE>
  | Action<ERewardStorePayloadlessActions>

export const RewardStoreReducer = (state = initialState, action: RewardStoreActions): IRewardStoreState => {
  switch (action.type) {
    case ERewardStorePayloadActions.POPULATE_STORE:
      return {
        ...state,
        loading: false,
        rewards: action.payload,
      }
    case ERewardStorePayloadlessActions.RESET_STORE:
      return initialState
    case ERewardStorePayloadlessActions.START_LOADING:
      return {
        ...state,
        loading: true,
      }
    case ERewardStorePayloadlessActions.STOP_LOADING:
      return {
        ...state,
        loading: false,
      }
    default:
      return state
  }
}
