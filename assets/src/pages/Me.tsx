import { Box, Stack, Text } from '@chakra-ui/react'
import { FC, useMemo } from 'react'
import { useSelector } from 'react-redux'
import { Bold } from '../components/textFormatting/Bold'
import { H1, H2 } from '../components/textFormatting/Headings'
import { consts } from '../consts'
import { RootState } from '../store'
import { IUser } from '../types/user'

export const Me: FC = () => {
  const userData = useSelector<RootState, IUser>(state => state.user.user_data)
  const { poolSpendUntil, poolSpendStart } = useMemo(() => {
    const poolSpendStart = new Date(userData.pool.year, userData.pool.month - 1)
    const poolSpendUntil = new Date(userData.pool.year, userData.pool.month)
    return {
      poolSpendStart,
      poolSpendUntil,
    }
  }, [userData])
  return (
    <Box maxW={consts.readableWidth} mx="auto" mt={12}>
      <H1>About you</H1>
      <H2>Data</H2>
      <Text>
        <Bold>Email:</Bold> {userData.email}
      </Text>
      <Text>
        <Bold>Points to spend:</Bold> {userData.spendable_points}
      </Text>
      <Text>
        <Bold>Sendable points:</Bold> {userData.pool.points}
      </Text>
      <Text>
        (You can send these points between {poolSpendStart.toLocaleDateString()} and{' '}
        {poolSpendUntil.toLocaleDateString()})
      </Text>
      <H2>Benefits</H2>
      <Stack>
        {userData.rewards?.map(reward => (
          <Box key={reward.id}>
            {reward.name} (${reward.price})
          </Box>
        ))}
      </Stack>
    </Box>
  )
}
