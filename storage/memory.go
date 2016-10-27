// package storage provides in memory storage implementation, for test purposes.
package storage

import (
	"errors"
	"sync"

	"github.com/apihub/apihub"
)

type Memory struct {
	mtx      sync.RWMutex
	services map[string]apihub.ServiceSpec
}

func New() *Memory {
	return &Memory{
		services: make(map[string]apihub.ServiceSpec),
	}
}

func (m *Memory) UpsertService(s apihub.ServiceSpec) error {
	m.mtx.Lock()
	defer m.mtx.Unlock()

	m.services[s.Handle] = s
	return nil
}

func (m *Memory) FindServiceByHandle(handle string) (apihub.ServiceSpec, error) {
	m.mtx.RLock()
	defer m.mtx.RUnlock()

	if service, ok := m.services[handle]; !ok {
		return apihub.ServiceSpec{}, errors.New("service not found")
	} else {
		return service, nil
	}
}

func (m *Memory) Services() ([]apihub.ServiceSpec, error) {
	m.mtx.RLock()
	defer m.mtx.RUnlock()

	services := []apihub.ServiceSpec{}
	for _, service := range m.services {
		services = append(services, service)
	}

	return services, nil
}