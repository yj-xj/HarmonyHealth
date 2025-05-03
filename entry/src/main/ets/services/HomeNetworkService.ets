import http from '@ohos.net.http'

// 健康计划数据接口
interface HealthPlanData {
  diet: string
  exercise: string
}

// 用户信息接口
interface UserInfo {
  username: string
  email: string
  avatar?: string
}

// 运动历史记录接口
interface ExerciseHistory {
  date: string
  exerciseType: string
  duration: number
}

// 基础响应接口
interface BaseResponse<T> {
  code: number
  message: string
  data: T
}

// HTTP错误接口
interface HttpError extends Error {
  code: number;
  message: string;
}

// 健康计划响应
interface HealthPlanResponse {
  plan: string;
}

export class HomeNetworkService {
  private static instance: HomeNetworkService
  private baseUrl: string = 'http://localhost:8000'

  private constructor() {
    console.info('[HomeNetworkService] 服务实例已初始化')
  }

  public static getInstance(): HomeNetworkService {
    if (!HomeNetworkService.instance) {
      console.info('[HomeNetworkService] 创建新的服务实例')
      HomeNetworkService.instance = new HomeNetworkService()
    }
    return HomeNetworkService.instance
  }

  // 生成健康计划
  async generateHealthPlan(): Promise<BaseResponse<HealthPlanResponse>> {
    console.info('[HomeNetworkService] 开始生成健康计划')
    let httpRequest = http.createHttp()
    try {
      let response = await httpRequest.request(
        this.baseUrl + '/api/health/plan/generate',
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json'
          }
        }
      )
      const result = JSON.parse(response.result as string) as BaseResponse<HealthPlanResponse>
      console.info(`[HomeNetworkService] 生成计划响应状态码: ${result.code}`)
      return result
    } catch (error: Error) {
      console.error(`[HomeNetworkService] 生成计划请求发生错误: ${error}`)
      const httpError: HttpError = new Error(error.message) as HttpError
      httpError.code = -1
      throw httpError
    } finally {
      httpRequest.destroy()
    }
  }

  // 获取指定日期的健康计划
  async getHealthPlanByDay(day: number): Promise<BaseResponse<HealthPlanData>> {
    console.info(`[HomeNetworkService] 开始获取第${day}天的健康计划`)
    let httpRequest = http.createHttp()
    try {
      let response = await httpRequest.request(
        this.baseUrl + `/api/health/plan/${day}`,
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          }
        }
      )
      const result = JSON.parse(response.result as string) as BaseResponse<HealthPlanData>
      console.info(`[HomeNetworkService] 获取计划响应状态码: ${result.code}`)
      return result
    } catch (error: Error) {
      console.error(`[HomeNetworkService] 获取计划请求发生错误: ${error}`)
      const httpError: HttpError = new Error(error.message) as HttpError
      httpError.code = -1
      throw httpError
    } finally {
      httpRequest.destroy()
    }
  }

  // 获取用户信息
  async getUserInfo(): Promise<BaseResponse<UserInfo>> {
    console.info('[HomeNetworkService] 开始获取用户信息')
    let httpRequest = http.createHttp()
    try {
      let response = await httpRequest.request(
        this.baseUrl + '/api/user/info',
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          }
        }
      )
      const result = JSON.parse(response.result as string) as BaseResponse<UserInfo>
      console.info(`[HomeNetworkService] 获取用户信息响应状态码: ${result.code}`)
      return result
    } catch (error: Error) {
      console.error(`[HomeNetworkService] 获取用户信息请求发生错误: ${error}`)
      const httpError: HttpError = new Error(error.message) as HttpError
      httpError.code = -1
      throw httpError
    } finally {
      httpRequest.destroy()
    }
  }

  // 获取运动历史
  async getExerciseHistory(): Promise<BaseResponse<ExerciseHistory[]>> {
    console.info('[HomeNetworkService] 开始获取运动历史')
    let httpRequest = http.createHttp()
    try {
      let response = await httpRequest.request(
        this.baseUrl + '/api/exercise/history',
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          }
        }
      )
      const result = JSON.parse(response.result as string) as BaseResponse<ExerciseHistory[]>
      console.info(`[HomeNetworkService] 获取运动历史响应状态码: ${result.code}`)
      return result
    } catch (error: Error) {
      console.error(`[HomeNetworkService] 获取运动历史请求发生错误: ${error}`)
      const httpError: HttpError = new Error(error.message) as HttpError
      httpError.code = -1
      throw httpError
    } finally {
      httpRequest.destroy()
    }
  }
}

export default HomeNetworkService.getInstance() 