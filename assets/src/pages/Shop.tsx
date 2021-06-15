import { Box, Stack } from '@chakra-ui/react'
import { FC, useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { consts } from '../consts'
import { AppDispatch, RootState } from '../store'
import { ERewardStorePayloadActions, ERewardStorePayloadlessActions, IRewardStoreState } from '../store/RewardStore'
import type { IReward } from '../types/reward'
import { client } from '../utils/client'

export const Shop: FC = () => {
  const dispatch = useDispatch<AppDispatch>()
  const loggedIn = useSelector<RootState, boolean>(state => state.user.logged_in)
  const { loading, rewards } = useSelector<RootState, IRewardStoreState>(state => state.store)
  useEffect(() => {
    async function fetchRewards() {
      dispatch({ type: ERewardStorePayloadlessActions.START_LOADING })
      const res = await client.get<{ data: IReward[] }>('/api/rewards')
      const data = res.data.data
      dispatch({ type: ERewardStorePayloadActions.POPULATE_STORE, payload: data })
    }
    if (loggedIn) fetchRewards()
  }, [loggedIn])
  return (
    <Box maxW={consts.readableWidth} mx="auto" mt="5rem">
      {loading ? (
        <div>loading...</div>
      ) : (
        <Stack>{rewards && rewards.map(reward => <Box key={reward.id}>{reward.name}</Box>)}</Stack>
      )}
    </Box>
  )
}
